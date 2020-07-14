using System;
using System.Reflection;

namespace WebMVC_WebAPI_EF_Study.Areas.HelpPage.ModelDescriptions
{
    public interface IModelDocumentationProvider
    {
        string GetDocumentation(MemberInfo member);

        string GetDocumentation(Type type);
    }
}