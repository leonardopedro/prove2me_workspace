-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge_apply_tmul
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesGaugeY2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterA4
open BookProof.NavierStokesGaugeY



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge_apply_tmul (p : NSAlg) (w : nsGhostSpace) :
    nsDerivBrstCharge (p ⊗ₜ[ℂ] w) = ∑ j : Fin 3, genY j p ⊗ₜ[ℂ] nsGhostCre j w := by sorry
