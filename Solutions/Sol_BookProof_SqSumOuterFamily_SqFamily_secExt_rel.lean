-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.secExt_rel
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_norm_le
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL

noncomputable section

variable (dim : ℕ → ℕ)
variable (F : SqFamily)

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) (u : (harmFried (F.dim n)).dom),
    ‖F.secExt n u‖ ≤ F.flK * ‖(harmFried (F.dim n)).op u + (u : L2d (F.dim n))‖ := fun n u => (F.secData n).ext_norm_le u
