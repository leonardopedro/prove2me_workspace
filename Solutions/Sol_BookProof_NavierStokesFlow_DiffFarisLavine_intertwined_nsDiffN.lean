-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.intertwined_nsDiffN
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffN_eq_ladder
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_Intertwined_add
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_Intertwined_comp
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_Intertwined_id
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_Intertwined_smul
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_Intertwined_sum
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_intertwined_ann
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_intertwined_cre
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) : Intertwined (velNcore mu) (nsDiffN mu) := by

  rw [nsDiffN_eq_ladder, velNcore]
  refine Intertwined.add ?_ (Intertwined.id.smul _)
  exact (Intertwined.sum Finset.univ fun i _ =>
    (intertwined_cre i).comp (intertwined_ann i)).smul _
