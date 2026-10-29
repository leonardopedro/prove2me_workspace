-- Generated from ChapterNsOneBodyDGamma.lean — theorem BookProof.NsOneBody.redHamDom_eq_sum_parcel
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
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
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterLeafGaps
import Definitions.Def_ChapterSirkBandLedger
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}
variable {n : ℕ}

theorem BookProof.NsOneBody.redHamDom_eq_sum_parcel (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    weylOpDom (redPiN n) (redFieldN nu k n)
      = ∑ p : Fin n, weylOpDom (parcelPi n p) (parcelField nu k n p) := by sorry
