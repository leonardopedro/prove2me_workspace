-- Generated from ChapterStandardBorelClassification.lean — solution of BookProof.ChapterStandardBorelClassification.transportUnitary_intertwines
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_transportUnitary_apply
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.ChapterStandardBorelClassification



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)

set_option maxHeartbeats 1000000 in
theorem solution {g : Y → ℂ} (hg : MemLp g ⊤ (Measure.map e mu))
    (v : Lp ℂ 2 (Measure.map e mu)) :
    transportUnitary e mu (multOp g hg v)
      = multOp (fun x => g (e x)) (memLp_top_comp_equiv e mu hg) (transportUnitary e mu v) := by

  refine Lp.ext ?_
  have h1 := transportIsom_coeFn e mu (multOp g hg v)
  have h2 := (measurePreserving_measurableEquiv e mu).quasiMeasurePreserving.ae_eq_comp
    (multOp_coeFn (μ := Measure.map e mu) g hg v)
  have h3 := multOp_coeFn (μ := mu) (fun x => g (e x)) (memLp_top_comp_equiv e mu hg)
    (transportIsom e mu v)
  have h4 := transportIsom_coeFn e mu v
  filter_upwards [h1, h2, h3, h4] with x hx1 hx2 hx3 hx4
  simp only [Function.comp_apply] at hx2
  rw [transportUnitary_apply, transportUnitary_apply, hx1, hx2, hx3, hx4]
