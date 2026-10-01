-- Generated from ChapterScalaronOuterFockFL.lean — solution of BookProof.ScalaronOuterFockFL.quadForm_secDiag_nonneg
import Mathlib
import Definitions.Def_ChapterScalaronOuterFockFL
import Theorems.Thm_BookProof_ScalaronOuterFockFL_quadForm_secDiag_eq
open BookProof.ScalaronOuterFockFL




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.DirectSumEsa BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : secCore (ι := ι)) : 0 ≤ quadForm (secDiag W Q) x := by

  obtain ⟨P, hP1, _⟩ := exists_band Q x
  rw [quadForm_secDiag_eq W Q x hP1]
  exact Finset.sum_nonneg fun a _ => ham_quadForm_nonneg W (Q.sig a) (Q.sig_nonneg a) _
