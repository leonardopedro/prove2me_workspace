-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsBos_nsGh_apply_tmul
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (S : Module.End ℂ NSAlg) (T : Module.End ℂ nsGhostSpace)
    (p : NSAlg) (w : nsGhostSpace) :
    (nsBos S * nsGh T) (p ⊗ₜ[ℂ] w) = S p ⊗ₜ[ℂ] T w := by

  simp [nsBos, nsGh, Module.End.mul_apply]
