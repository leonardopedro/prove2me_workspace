-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge_apply_tmul
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_glin_bos_apply_tmul
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : NSAlg) (w : nsGhostSpace) :
    nsDerivBrstCharge (p ⊗ₜ[ℂ] w) = ∑ j : Fin 3, genY j p ⊗ₜ[ℂ] nsGhostCre j w := glin_bos_apply_tmul genY p w
