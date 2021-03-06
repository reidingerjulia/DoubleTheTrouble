module DTT.Data.OutputForm exposing (OutputForm, codec, error, secrets, todo)

import Codec exposing (Codec)
import DTT.Data.Error as Error exposing (ErrorJson)
import DTT.Data.Secret as Secret exposing (Secret)
import DTT.Data.TodoEntry as TodoEntry exposing (TodoEntry)


type alias OutputForm =
    { error : Maybe ErrorJson
    , todo : Maybe (List TodoEntry)
    , secrets : Maybe (List Secret)
    }


empty : OutputForm
empty =
    { error = Nothing
    , todo = Nothing
    , secrets = Nothing
    }


error : ErrorJson -> OutputForm
error err =
    { empty | error = Just err }


todo : List TodoEntry -> OutputForm
todo list =
    { empty | todo = Just list }


secrets : List Secret -> OutputForm
secrets list =
    { empty | secrets = Just list }


codec : Codec OutputForm
codec =
    Codec.object OutputForm
        |> Codec.field "error" .error (Codec.maybe <| Error.codec)
        |> Codec.field "todo" .todo (Codec.maybe <| Codec.list <| TodoEntry.codec)
        |> Codec.field "secrets" .secrets (Codec.maybe <| Codec.list <| Secret.codec)
        |> Codec.buildObject
