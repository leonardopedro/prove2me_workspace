-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.qgOuterFriedN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
import Theorems.Thm_BookProof_QgOuterFockFL_qgOuterFriedN_apply
import Theorems.Thm_BookProof_QgOuterFockFL_qgOuterCore_le_friedDom
import Theorems.Thm_BookProof_QgOuterFockFL_polyGaussCore_le_harmFriedDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.QgOuterFockFL



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable (C : ∀ i, Comparison (G i))
variable (H : ∀ i, (C i).dom →ₗ[ℂ] G i)
variable {C H}

set_option maxHeartbeats 2000000 in

theorem solution :
    IsPositiveSelfAdjointExtension qgOuterN qgOuterFriedN :=
  qgOuterComparison.isPositiveSelfAdjointExtension qgOuterN (fun x => by
    refine ⟨qgOuterCore_le_friedDom x.2, ?_⟩
    refine lp.ext (funext fun n => ?_)
    rw [qgOuterFriedN_apply]
    refine (harmFried_op_core (n * 84) ⟨(x : BookProof.QgOuterFock.qgOuterFock) n, x.2.2 n⟩
      (polyGaussCore_le_harmFriedDom (n * 84) (x.2.2 n))).trans ?_
    exact rfl)
