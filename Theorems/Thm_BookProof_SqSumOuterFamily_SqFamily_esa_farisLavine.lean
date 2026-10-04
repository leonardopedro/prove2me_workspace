-- Generated from ChapterSqSumOuterFamily.lean — theorem BookProof.SqSumOuterFamily.SqFamily.esa_farisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL
open BookProof.SqSumOuterFamily

variable (dim : ℕ → ℕ)
variable (F : SqFamily)



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

theorem BookProof.SqSumOuterFamily.SqFamily.esa_farisLavine :
    EssentiallySelfAdjointOn (outerFriedDom F.dim)
        (dsFibOp (fun n : ℕ => harmFried (F.dim n)) F.secExt F.flK F.secExt_rel) ∧
      ∀ x : outerCore F.dim, ∃ h : (x : outerFock F.dim) ∈ outerFriedDom F.dim,
        dsFibOp (fun n : ℕ => harmFried (F.dim n)) F.secExt F.flK F.secExt_rel
            ⟨(x : outerFock F.dim), h⟩ = F.outerHam x := by sorry
