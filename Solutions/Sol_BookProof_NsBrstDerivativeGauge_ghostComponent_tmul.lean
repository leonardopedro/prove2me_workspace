-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.ghostComponent_tmul
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2
open BookProof.NavierStokesGaugeY

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : NSAlg) (w : nsGhostSpace) :
    ghostComponent (p ⊗ₜ[ℂ] w) = (MvPolynomial.aeval (fun _ => (0 : ℂ)) p) • w := by

  simp [ghostComponent]
