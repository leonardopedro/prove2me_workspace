-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.core_ext
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_span_coreState
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
njective
    (Submodule.injective_subtype (lpFiniteModes Vel)) ?_
  rw [Submodule.map_span, Submodule.map_top, Submodule.range_subtype, ← Set.range_comp]
  exact lpFiniteModes_eq_span.symm

/-- Two linear maps out of the finite-mode core agree as soon as the :=
  y agree on the basis
  states. -/
  theorem core_ext {M : Type*} [AddCommGroup M] [Module ℂ M]
      {F G : lpFiniteModes Vel →ₗ[ℂ] M} (h : ∀ b, F (coreState b) = G (coreState b)) : F = G := by
    refine LinearMap.ext fun x => ?_
    have hx : x ∈ Submodule.span ℂ (Set.range coreState) := by rw [span_coreState]; trivial
    induction hx using Submodule.s
