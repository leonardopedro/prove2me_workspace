-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.velNcore_eq_diagMax
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_crd_numSeq
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
theorem solution (mu : ℝ) (x : lpFiniteModes Vel) :
    ((velNcore mu x : lpFiniteModes Vel) : L2I Vel)
      = (diagMax (velSym mu)
          (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x) : L2I Vel) := by

  refine lp.ext (funext fun β => ?_)
  have hleft : (((velNcore mu x : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β
      = ((2 * mu : ℝ) : ℂ) * (∑ _i : Fin 3, ((β _i : ℝ) : ℂ) * crd x β)
        + ((3 * mu + 1 : ℝ) : ℂ) * crd x β := by
    simp only [velNcore, LinearMap.add_apply, LinearMap.smul_apply, LinearMap.id_apply]
    have h1 : crd ((((2 * mu : ℝ) : ℂ)) • (∑ i, numSeq i) x
        + (((3 * mu + 1 : ℝ) : ℂ)) • x) β
        = ((2 * mu : ℝ) : ℂ) * crd ((∑ i, numSeq i) x) β
          + ((3 * mu + 1 : ℝ) : ℂ) * crd x β := by
      simp [crd_add, crd_smul]
    have h2 : crd ((∑ i, numSeq i) x) β = ∑ i, ((β i : ℝ) : ℂ) * crd x β := by
      rw [LinearMap.sum_apply]
      have : ∀ s : Finset (Fin 3), crd (∑ i ∈ s, numSeq i x) β
          = ∑ i ∈ s, crd (numSeq i x) β := by
        intro s
        induction s using Finset.induction with
        | empty => simp [crd]
        | insert i s hi ih => rw [Finset.sum_insert hi, Finset.sum_insert hi, crd_add]; simp [ih]
      rw [this]
      exact Finset.sum_congr rfl fun i _ => crd_numSeq i x β
    change crd ((((2 * mu : ℝ) : ℂ)) • (∑ i, numSeq i) x
        + (((3 * mu + 1 : ℝ) : ℂ)) • x) β = _
    rw [h1, h2]
  have hstep : (∑ _i : Fin 3, ((β _i : ℝ) : ℂ) * crd x β) = ((total β : ℕ) : ℂ) * crd x β := by
    rw [← Finset.sum_mul]
    congr 1
    simp only [total, Nat.cast_sum]
    push_cast
    rfl
  have hright : ((diagMax (velSym mu)
        (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x) : L2I Vel) : Vel → ℂ) β
      = ((velSym mu β : ℝ) : ℂ) * crd x β := rfl
  rw [hleft, hstep, hright]
  simp only [velSym]
  push_cast
  ring
