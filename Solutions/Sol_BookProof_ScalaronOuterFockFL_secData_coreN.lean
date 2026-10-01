-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.secData_coreN
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : secCore (ι := ι)) :
    (secData W Q).coreN p = secDiag W Q p := secN_core W Q p
