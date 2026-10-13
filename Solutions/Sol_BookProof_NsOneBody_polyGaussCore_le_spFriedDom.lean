-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.polyGaussCore_le_spFriedDom
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    (polyGaussCore (d := 6)) ≤ (spFried nu k).dom :=
  fun v hv =>
    (friedrichsComparison_extends (spPosSym nu k) polyGaussCore_dense ⟨v, hv⟩).choose
