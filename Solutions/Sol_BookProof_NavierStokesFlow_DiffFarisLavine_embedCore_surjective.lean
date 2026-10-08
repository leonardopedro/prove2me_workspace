-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.embedCore_surjective
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_hermiteMvLp_mem_range
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Function.Surjective (embedCore) := by

  intro f
  have hmap : (polyGaussCore (d := 3))
      ≤ Submodule.map ((polyGaussCore (d := 3)).subtype) (LinearMap.range embedCore) := by
    have hspan : Submodule.span ℂ (Set.range (hermiteMvLp (d := 3)))
        ≤ Submodule.map ((polyGaussCore (d := 3)).subtype) (LinearMap.range embedCore) := by
      rw [Submodule.span_le]
      rintro _ ⟨a, rfl⟩
      exact hermiteMvLp_mem_range a
    rwa [span_hermiteMvLp] at hspan
  obtain ⟨g, hg, hgf⟩ := hmap f.2
  obtain ⟨x, hx⟩ := hg
  exact ⟨x, Subtype.ext (by rw [hx]; exact hgf)⟩
