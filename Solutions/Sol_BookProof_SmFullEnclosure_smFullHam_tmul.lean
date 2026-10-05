-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFullHam_tmul
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Theorems.Thm_BookProof_TensorSumEsa_cpairOp_apply
open BookProof.SmFullEnclosure




open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ)
    (x : ↥(smFullCore n)) (u : ↥(polyGaussCore (d := 163))) (ψ : ↥(fullDom n))
    (hx : (x : (smFullSpace n).carrier)
      = pairEmb (L2dSpace 163) (smFermiSpace n)
          (inclPair (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
            (u ⊗ₜ[ℂ] ψ : ↥(polyGaussCore (d := 163)) ⊗[ℂ] ↥(fullDom n)))) :
    smFullHam P hD M z x
      = pairEmb (L2dSpace 163) (smFermiSpace n)
          ((smHamiltonian P) u ⊗ₜ[ℂ] (ψ : FermiFock n)
            + (u : L2d 163) ⊗ₜ[ℂ] (smDirac hD + smYukawa M z) ψ) := by

  refine (cpairOp_apply _ _ _ _ _ _ x
    (u ⊗ₜ[ℂ] ψ : ↥(polyGaussCore (d := 163)) ⊗[ℂ] ↥(fullDom n)) hx).trans ?_
  rw [← smFermiHam_eq]
  rfl
