-- Generated from ChapterNsBrstDerivativeGauge.lean — theorem BookProof.NsBrstDerivativeGauge.glin_bos_apply_tmul
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterNavierStokesGaugeY2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY
open BookProof.NsBrstDerivativeGauge



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

theorem BookProof.NsBrstDerivativeGauge.glin_bos_apply_tmul (G : Fin 3 → Module.End ℂ NSAlg) (p : NSAlg) (w : nsGhostSpace) :
    glin (fun j => nsBos (G j)) nsChi (p ⊗ₜ[ℂ] w)
      = ∑ j : Fin 3, G j p ⊗ₜ[ℂ] nsGhostCre j w := by sorry
