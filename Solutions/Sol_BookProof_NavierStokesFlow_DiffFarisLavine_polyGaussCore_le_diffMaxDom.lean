-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.polyGaussCore_le_diffMaxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_embedCore_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) : (polyGaussCore (d := 3)) ≤ diffMaxDom mu := by

  intro v hv
  obtain ⟨x, hx⟩ := embedCore_surjective ⟨v, hv⟩
  refine ⟨(x : L2I Vel), finiteModes_le_maxDom (velSym mu) x.2, ?_⟩
  have hcoe := congrArg (fun w : polyGaussCore (d := 3) => (w : L2d 3)) hx
  simpa [embedCore_coe] using hcoe
