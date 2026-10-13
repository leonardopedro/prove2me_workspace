-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.flc_nonneg
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterMajoranaClifford
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open BookProof.MajoranaClifford

noncomputable section

variable (dim : ℕ → ℕ)
variable (F : SqFamily)

set_option maxHeartbeats 1000000 in
theorem solution : 0 ≤ F.flc := by

  have h := F.ab_nonneg
  have := F.km_nonneg
  rw [flc]; linarith
