-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.glin_bos_apply_tmul
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsBos_nsGh_apply_tmul
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (G : Fin 3 → Module.End ℂ NSAlg) (p : NSAlg) (w : nsGhostSpace) :
    glin (fun j => nsBos (G j)) nsChi (p ⊗ₜ[ℂ] w)
      = ∑ j : Fin 3, G j p ⊗ₜ[ℂ] nsGhostCre j w := by

  rw [glin, LinearMap.sum_apply]
  exact Finset.sum_congr rfl fun j _ => nsBos_nsGh_apply_tmul (G j) (nsGhostCre j) p w
