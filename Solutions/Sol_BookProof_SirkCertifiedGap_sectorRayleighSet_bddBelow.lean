-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.sectorRayleighSet_bddBelow
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T : E →ₗ[ℂ] E} (P : E →ₗ[ℂ] E) (s : ℝ)
    (hT : T.IsSymmetric) : BddBelow (sectorRayleighSet T P s) := by

  classical
  rcases Set.eq_empty_or_nonempty (sectorRayleighSet T P s) with h | ⟨r, x, hx, -, -⟩
  · rw [h]; exact bddBelow_empty
  · have hx0 : x ≠ 0 := by
      intro h; rw [h] at hx; simp at hx
    have hne := index_nonempty hT rfl hx0
    refine ⟨univ.inf' hne fun i => hT.eigenvalues (rfl : Module.finrank ℂ E = _) i, ?_⟩
    rintro r ⟨y, hy, -, rfl⟩
    exact ground_le_rayleigh hT rfl hy fun i => Finset.inf'_le _ (mem_univ i)
