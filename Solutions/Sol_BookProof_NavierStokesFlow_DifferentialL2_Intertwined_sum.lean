-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.Intertwined.sum
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2.Intertwined




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι)
    {T : ι → lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel}
    {T' : ι → (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3))}
    (h : ∀ i ∈ s, Intertwined (T i) (T' i)) :
    Intertwined (∑ i ∈ s, T i) (∑ i ∈ s, T' i) :=
  fun x => by
    simp only [LinearMap.sum_apply]
    rw [map_sum]
    exact Finset.sum_congr rfl fun i hi => h i hi x
