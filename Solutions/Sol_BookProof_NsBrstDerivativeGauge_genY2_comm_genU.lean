-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genY2_comm_genU
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_pderiv_u_mul_uL
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_swap
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_u_mul_uD
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
theorem solution (i j : Fin 3) : genY2 j * genU i = genU i * genY2 j := by

  refine LinearMap.ext fun p => ?_
  have h : ∀ k : Fin 3, pderiv (NSVar.u i) (X (NSVar.uD k j) * pderiv (NSVar.u k) p)
      = X (NSVar.uD k j) * pderiv (NSVar.u k) (pderiv (NSVar.u i) p) := fun k => by
    rw [pderiv_u_mul_uD, pderiv_swap (NSVar.u i) (NSVar.u k)]
  have h2 : ∀ k : Fin 3, pderiv (NSVar.u i) (X (NSVar.uL k) * pderiv (NSVar.uD k j) p)
      = X (NSVar.uL k) * pderiv (NSVar.uD k j) (pderiv (NSVar.u i) p) := fun k => by
    rw [pderiv_u_mul_uL, pderiv_swap (NSVar.u i) (NSVar.uD k j)]
  simp only [Module.End.mul_apply, genU_apply, genY2_apply_loc, map_sub, map_sum,
    pderiv_swap (NSVar.u i) (NSVar.y j), h, h2]
