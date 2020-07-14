<!-- Header page -->
<!-- Author: xwang -->

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="hf" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="hh" %>

<hf:subview id="header">
   <hh:form id="headerForm">
      <table class="headerPage" width="100%" border=0 cellspacing=0>
         <tr>
            <td width="70%">
               <div class="headerPageTitle">Web Application</div>
            </td>
            <td width="*">
               <div class="commandBar" align="right">
                  <span>
                     <hh:outputLink styleClass="commandLink" value="front.faces">
                        <hf:verbatim>Home</hf:verbatim>
                     </hh:outputLink>
                  </span>
                  &nbsp;&nbsp;
                  <span>
                     <hh:commandLink styleClass="commandLink" action="#{loginBean.invoke_logout}" 
                                    rendered="#{loginBean.loggedIn=='true'}">
                        <hh:outputText value="Logout"/>
                     </hh:commandLink>	
                  </span>
               </div>
            </td>
         </tr>
      </table>
   </hh:form>
</hf:subview>