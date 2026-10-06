-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.constrainedSpectrum_eq_univ_of_isUnconstrained
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Theorems.Thm_BookProof_ChapterGaugeUnconstrainedSpectrum_diagOp_injective
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution {U : G → Op X}
    (hU : IsUnconstrainedGaugeFixing U) (hU1 : U 1 = LinearMap.id) :
    constrainedSpectrum U = Set.univ := by

  ext x
  simp only [constrainedSpectrum, Set.mem_setOf_eq, Set.mem_univ, iff_true]
  intro g d hd
  by_cases hg : g = 1
  · subst hg
    have hid : diagOp (fun _ : X => (1 : ℂ)) = diagOp d := by
      rw [← hd, hU1]; ext f x; simp
    have := diagOp_injective hid
    exact (congrFun this x).symm
  · exact absurd ⟨d, hd⟩ (hU g hg)
