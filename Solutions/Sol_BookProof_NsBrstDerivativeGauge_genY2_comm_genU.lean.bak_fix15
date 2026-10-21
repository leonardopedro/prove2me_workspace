-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genY2_comm_genU
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_pderiv_u_mul_uL
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_swap
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_u_mul_uD
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) : genY2 j * genU i = genU i * genY2 j := by

  refine LinearMap.ext fun p => ?_
  have h : ∀ k : Fin 3, pderiv (NSVar.u i) (X (NSVar.uD k j) * pderiv (NSVar.u k) p)
      = X (NSVar.uD k j) * pderiv (NSVar.u k) (pderiv (NSVar.u i) p) := fun k => by
    rw [pderiv_u_mul_uD, pderiv_swap (NSVar.u i) (NSVar.u k)]
  have h2 : ∀ k : Fin 3, pderiv (NSVar.u i) (X (NSVar.uL k) * pderiv (NSVar.uD k j) p)
      = X (NSVar.uL k) * pderiv (NSVar.uD k j) (pderiv (NSVar.u i) p) := fun k => by
    rw [pderiv_u_mul_uL, pderiv_swap (NSVar.u i) (NSVar.uD k j)]
  simp only [Module.End.mul_apply, genU_apply, genY2_apply, map_sub, map_sum,
    pderiv_swap (NSVar.u i) (NSVar.y j), h, h2]
