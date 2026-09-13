-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.embedCore_surjective
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_hermiteMvLp_mem_range
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine














open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
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
