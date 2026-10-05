-- Generated from ChapterNsOneBodyDGamma.lean — theorem BookProof.NsOneBody.nsSpDGamma_number_conserving
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.NsOneBody

variable {D : Submodule ℂ (L2d 6)}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.NsOneBody.nsSpDGamma_number_conserving (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ)
    {n : ℕ} {u : FockAlg} (hu : InSector n u) : InSector n (dGamma (nsSpCol e nu k) u) := by sorry
