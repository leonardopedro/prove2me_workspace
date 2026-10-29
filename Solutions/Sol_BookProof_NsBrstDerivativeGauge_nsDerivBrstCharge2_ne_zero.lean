-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_ne_zero
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsDerivBrstCharge2_apply_tmul
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_ghostComponent_tmul
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesGaugeY2
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2

noncomputable section

-- Inlined from the (partial) published def bundle: `BookProof.NavierStokesGaugeY2.genY2_apply`
-- is not declared server-side, so restate it locally.
private theorem genY2_apply_loc (j : Fin 3) (p : NSAlg) :
    genY2 j p = pderiv (NSVar.y j) p
      - (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uL i) * pderiv (NSVar.uD i j) p := by
  simp [genY2]

set_option maxHeartbeats 1000000 in
theorem solution : nsDerivBrstCharge2 ≠ 0 := by

  intro h
  have happ : nsDerivBrstCharge2 (X (NSVar.y 0) ⊗ₜ[ℂ] (1 : nsGhostSpace)) = 0 := by
    rw [h]; simp
  rw [nsDerivBrstCharge2_apply_tmul] at happ
  have hterm : ∀ j : Fin 3, j ≠ 0 →
      genY2 j (X (NSVar.y 0)) ⊗ₜ[ℂ] nsGhostCre j (1 : nsGhostSpace) = 0 := by
    intro j hj
    have hzero : genY2 j (X (NSVar.y 0)) = 0 := by
      simp [genY2_apply_loc, pderiv_X, Ne.symm hj]
    rw [hzero, TensorProduct.zero_tmul]
  rw [Finset.sum_eq_single (0 : Fin 3) (fun j _ hj => hterm j hj) (by simp)] at happ
  have h0 : genY2 (0 : Fin 3) (X (NSVar.y 0)) = 1 := by
    simp [genY2_apply_loc, pderiv_X]
  rw [h0] at happ
  have hgh := congrArg ghostComponent happ
  rw [ghostComponent_tmul] at hgh
  simp [nsGhostCre] at hgh
