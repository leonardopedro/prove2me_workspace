-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_esa_of_farisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_polyGaussCore_le_diffMaxDom
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxH_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_quadForm_nonneg
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_add_one_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_core_approx
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxH_relative_bound
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxH_commForm_bound
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxH_restrict
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine














open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

















variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution :
    EssentiallySelfAdjointOn (polyGaussCore (d := 3))
      ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) := by

  obtain ⟨a, b, _, _, hrel⟩ := diffMaxH_relative_bound A c
  obtain ⟨cst, hcst, hcomm⟩ := diffMaxH_commForm_bound A c
  have hesa := essentiallySelfAdjointOn_core_of_farisLavine
    (polyGaussCore_le_diffMaxDom (velMu A (seqConst c))) (diffMaxH A c)
    (diffMaxN (velMu A (seqConst c))) a b cst (diffMaxH_symmetricOn A c)
    (diffMaxN_symmetricOn _) hcst
    (diffMaxN_quadForm_nonneg _ (velMu_nonneg A (seqConst c)))
    (diffMaxN_add_one_surjective _ (velMu_nonneg A (seqConst c))) hcomm hrel
    (fun z ε hε => diffMaxN_core_approx _ z ε hε)
  rwa [diffMaxH_restrict] at hesa
