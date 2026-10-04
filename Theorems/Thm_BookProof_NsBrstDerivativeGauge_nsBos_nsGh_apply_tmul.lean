-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.nsBos_nsGh_apply_tmul
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesGaugeY2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterA4
open BookProof.NavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.nsBos_nsGh_apply_tmul (S : Module.End ℂ NSAlg) (T : Module.End ℂ nsGhostSpace)
    (p : NSAlg) (w : nsGhostSpace) :
    (nsBos S * nsGh T) (p ⊗ₜ[ℂ] w) = S p ⊗ₜ[ℂ] T w := by sorry
