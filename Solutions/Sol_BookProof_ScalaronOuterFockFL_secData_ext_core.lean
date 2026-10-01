-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secData_ext_core
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_core
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : secCore (ι := ι)) :
    (secData W Q).ext ⟨(p : Sec ι), (secData W Q).gc.le p.2⟩ = secHam W Q p := (secData W Q).ext_core p
