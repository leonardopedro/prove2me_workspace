-- Generated from ChapterNsOneBodyDGamma.lean — theorem BookProof.NsOneBody.weylOpDom_block_sum
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs
open BookProof.NsOneBody

variable {D : Submodule ℂ (L2d 6)}
variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.NsOneBody.weylOpDom_block_sum {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D : Submodule ℂ F} {a b c : ℕ} (pi : Fin (a * b) → D →ₗ[ℂ] D)
    (Bf : Fin (a * c) → D →ₗ[ℂ] D) :
    weylOpDom pi Bf
      = ∑ p : Fin a, weylOpDom (fun i : Fin b => pi (finProdFinEquiv (p, i)))
          (fun r : Fin c => Bf (finProdFinEquiv (p, r))) := by sorry
