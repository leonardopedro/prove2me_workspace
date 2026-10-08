-- Generated from ChapterRadialLaplacian.lean — solution of BookProof.ChapterRadialLaplacian.contDiffAt_sbessel_zero
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_contDiffOn_gIter
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_sbessel_eq
open BookProof.ChapterRadialLaplacian




open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : r ≠ 0) : ContDiffAt ℝ 2 (sbessel 0) r := by

  have h : ContDiffOn ℝ (⊤ : ℕ∞) (gIter 0) {s : ℝ | s ≠ 0} := contDiffOn_gIter 0
  have hfun : sbessel 0 = gIter 0 := by
    funext s; rw [sbessel_eq]; simp
  have hat : ContDiffAt ℝ (⊤ : ℕ∞) (gIter 0) r :=
    (h.contDiffAt (isOpen_ne.mem_nhds hr))
  rw [hfun]
  exact hat.of_le ENat.LEInfty.out
