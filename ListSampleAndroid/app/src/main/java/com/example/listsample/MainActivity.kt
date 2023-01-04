package com.example.listsample

import android.content.res.Configuration
import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.annotation.RequiresApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.listsample.model.HomeViewModel
import com.example.listsample.model.Message
import com.example.listsample.ui.theme.ListSampleTheme
import java.text.SimpleDateFormat
import java.util.*


class MainActivity : ComponentActivity() {
    private val homeViewModel: HomeViewModel by viewModels()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        homeViewModel.loadData()
        setContent {
            MainScreen(homeViewModel)
        }
    }
}

@Composable
fun MainScreen(homeViewModel: HomeViewModel) {
    val focusManager = LocalFocusManager.current
    val interactionSource = remember {
        MutableInteractionSource()
    }
    Column(modifier = Modifier.clickable(
        interactionSource = interactionSource,
        indication = null) {
        focusManager.clearFocus()
    }) {
        InputHead(homeViewModel.text.value, { it
            homeViewModel.updateText(it)
        }) {
            homeViewModel.addMessage()
        }
        Conversation(messages = homeViewModel.messages.value)
    }
}

@Composable
fun InputHead(text: String, onTextChange: (it:String) -> Unit, onButtonClick: () -> Unit) {
    Row(modifier = Modifier.padding(10.dp), verticalAlignment = Alignment.CenterVertically){
        OutlinedTextField(value = text, onValueChange = onTextChange, Modifier.weight(1f))
        Spacer(modifier = Modifier.width(10.dp))
        Button(onClick = onButtonClick, contentPadding = PaddingValues(10.dp, 10.dp)) {
            Text(text = "发送")
        }
    }

}

@Composable
fun Conversation(messages: List<Message>) {
    LazyColumn {
        items(messages) { message ->
            MessageCard(message)
        }
    }
}

@RequiresApi(Build.VERSION_CODES.O)
@Preview(showBackground = true)
@Composable
fun PreviewMain() {
    MainScreen(homeViewModel = viewModel())
}

@Composable
fun MessageCard(message: Message) {
    Row(modifier = Modifier.padding(all = 8.dp)) {
        Image(
            painter = painterResource(id = R.drawable.m),
            contentDescription = "McDonald's",
            modifier = Modifier
                .size(40.dp)
                .clip(CircleShape)
                .border(1.5.dp, MaterialTheme.colors.secondaryVariant, CircleShape)
        )
        Spacer(modifier = Modifier.width(8.dp))
        Column(modifier = Modifier.weight(1f)) {
            val df = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
            val timeStr = df.format(message.time)

            Text(
                text = message.content + " #" + message.id,
                color = MaterialTheme.colors.secondaryVariant,
                style = MaterialTheme.typography.subtitle2
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = timeStr,
                style = MaterialTheme.typography.body2
            )
        }
    }
}


@Preview(name = "Light Mode")
@Preview(
    uiMode = Configuration.UI_MODE_NIGHT_YES,
    showBackground = true,
    name = "Dark Mode"
)
@Composable
fun PreviewMessageCard() {
    ListSampleTheme {
        Surface {
            MessageCard(Message(1, "AAA", Date()))
        }
    }
}