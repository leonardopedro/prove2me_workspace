-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.higgsMul_relBound
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmYukawaCoupling_norm_higgsMul_sq_le
import Theorems.Thm_BookProof_SmYukawaCoupling_norm_wall_sq_le_quadForm
import Theorems.Thm_BookProof_SmYukawaCoupling_quadForm_le
import Theorems.Thm_BookProof_SmYukawaCoupling_real_relBound
import Theorems.Thm_BookProof_SmYukawaCoupling_higgsMul_apply
import Theorems.Thm_BookProof_SmYukawaCoupling_smField_wall_apply
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (hlam : 0 < P.lam) (a : Fin 4) :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : polyGaussCore (d := 163),
      ‖higgsMul a u‖ ≤ ε * ‖smHamiltonian P u‖ + C * ‖(u : L2d 163)‖ := by

  intro ε hε
  refine ⟨Real.sqrt ((4 / P.lam) ^ 2 / (4 * ε ^ 2) + (P.vev ^ 2 + 1 / 4)), fun u => ?_⟩
  obtain ⟨p, rfl⟩ : ∃ p, u = (coreRepPoly 163).equiv p :=
    ⟨_, ((coreRepPoly 163).equiv.apply_symm_apply u).symm⟩
  have h1 := norm_higgsMul_sq_le P hlam a p
  rw [← higgsMul_apply, ← smField_wall_apply, ← (coreRepPoly 163).coe_equiv p] at h1
  exact real_relBound hlam (by positivity) hε (norm_nonneg _) (norm_nonneg _) (norm_nonneg _)
    h1 (norm_wall_sq_le_quadForm P _) (quadForm_le P _)
