-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsGh_mul
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
theorem solution (S T : Module.End ℂ nsGhostSpace) : nsGh (S * T) = nsGh S * nsGh T := by

  simp [nsGh, Module.End.mul_eq_comp, LinearMap.lTensor_comp]
