-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_apply_tmul
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterA4
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY2
open BookProof.NsBrstDerivativeGauge



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_apply_tmul (p : NSAlg) (w : nsGhostSpace) :
    nsDerivBrstCharge2 (p ⊗ₜ[ℂ] w) = ∑ j : Fin 3, genY2 j p ⊗ₜ[ℂ] nsGhostCre j w := by sorry
