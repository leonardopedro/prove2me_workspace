-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.secData_commForm_le
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secHam_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockCoreFL
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
open BookProof.QgHermiteOscillator
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

noncomputable section

variable (dim : ℕ → ℕ)
variable (F : SqFamily)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (p : (F.secData n).C₀) :
    |commForm (F.secData n).H₀ (F.secData n).coreN p|
      ≤ F.flc * quadForm (F.secData n).coreN p := by

  have hN : (F.secData n).coreN p = harmCore p :=
    harmFried_op_core (F.dim n) p _
  have h1 : commForm (F.secData n).H₀ (F.secData n).coreN p
      = commForm (F.secHam n) (harmCore (d := F.dim n)) p :=
    commForm_congr (F.secData n).H₀ (F.secData n).coreN (F.secHam n)
      (harmCore (d := F.dim n)) p p rfl hN
  have h2 : quadForm (F.secData n).coreN p = quadForm (harmCore (d := F.dim n)) p :=
    quadForm_congr (F.secData n).coreN (harmCore (d := F.dim n)) p p rfl hN
  rw [h1, h2]
  exact F.secHam_commForm_le n p
