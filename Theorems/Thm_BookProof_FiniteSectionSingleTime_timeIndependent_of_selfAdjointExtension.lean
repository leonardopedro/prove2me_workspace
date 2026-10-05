-- Generated from ChapterFiniteSectionSingleTime.lean — theorem BookProof.FiniteSectionSingleTime.timeIndependent_of_selfAdjointExtension
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.EsaClosure
open BookProof.StoneBridge
open BookProof.FiniteSectionSingleTime

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section


theorem BookProof.FiniteSectionSingleTime.timeIndependent_of_selfAdjointExtension {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (hdense : Dense ((D : Submodule ℂ F) : Set F))
    (h : IsSelfAdjointExtension Hc A) :
    ∃ T : UnboundedSelfAdjoint F,
      IsSelfAdjointExtension Hc T.op ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : F), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : F), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → F, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) := by sorry
