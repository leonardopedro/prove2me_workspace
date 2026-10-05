-- Generated from ChapterAtomicDiagonalModel.lean — solution of BookProof.ChapterAtomicDiagonalModel.multOp_atomVec
import Mathlib
import Definitions.Def_ChapterAtomicDiagonalModel
import Theorems.Thm_BookProof_ChapterAtomicDiagonalModel_atomVec_coeFn
open BookProof.ChapterAtomicDiagonalModel



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

set_option maxHeartbeats 1000000 in
theorem solution {g : α → ℂ} (hg : MemLp g ⊤ mu) (a : atomSet mu) :
    multOp g hg (atomVec mu a) = g (a : α) • atomVec mu a := by

  refine Lp.ext ?_
  filter_upwards [multOp_coeFn (μ := mu) g hg (atomVec mu a),
    Lp.coeFn_smul (g (a : α)) (atomVec mu a), atomVec_coeFn mu a] with x hx1 hx2 hx3
  rw [hx1, hx2]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [hx3]
  by_cases hxa : x = (a : α)
  · subst hxa
    simp
  · simp [Set.indicator_of_notMem, hxa]
