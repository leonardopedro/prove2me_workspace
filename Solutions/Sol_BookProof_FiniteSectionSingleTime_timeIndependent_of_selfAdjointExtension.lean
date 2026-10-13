-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.timeIndependent_of_selfAdjointExtension
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_QgTimeIndependent_eq_prop_of_isSchrodingerSolution
import Theorems.Thm_BookProof_QgTimeIndependent_norm_prop_apply
import Theorems.Thm_BookProof_QgTimeIndependent_prop_apply_prop
import Theorems.Thm_BookProof_QgTimeIndependent_prop_time_translation
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.FiniteSectionSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.EsaClosure
open BookProof.StoneBridge

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (hdense : Dense ((D : Submodule ℂ F) : Set F))
    (h : IsSelfAdjointExtension Hc A) :
    ∃ T : UnboundedSelfAdjoint F,
      IsSelfAdjointExtension Hc T.op ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : F), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : F), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → F, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) :=
  ⟨unboundedSelfAdjointOf hdense h, h, fun _ _ => rfl,
      fun t s x => norm_prop_apply _ t s x, fun t s r x => prop_apply_prop _ t s r x,
      fun t s u => prop_time_translation _ t s u,
      fun _ hy t s => eq_prop_of_isSchrodingerSolution _ hy t s⟩
