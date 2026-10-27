-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.navierStokes_fock_hamiltonian_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumEsa_nsSymbol_nonneg
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumEsa_fock_ns_hamiltonian_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ)
    (p q : Fin d → ℕ → ℝ)
    (H : maxDom (nsFockSymbol d p q) →ₗ[ℂ] L2I Config) (a b cst : ℝ)
    (hH : SymmetricOn (maxDom (nsFockSymbol d p q)) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom (nsFockSymbol d p q),
      ‖H x‖ ^ 2 ≤ a * ‖diagMax (nsFockSymbol d p q) x‖ ^ 2 + b * ‖(x : L2I Config)‖ ^ 2)
    (hcomm : ∀ x : maxDom (nsFockSymbol d p q),
      |commForm H (diagMax (nsFockSymbol d p q)) x|
        ≤ cst * quadForm (diagMax (nsFockSymbol d p q)) x) :
    EssentiallySelfAdjointOn (lpFiniteModes Config)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom (nsFockSymbol d p q)))) :=
  fock_ns_hamiltonian_essentiallySelfAdjointOn_core _ (nsSymbol_nonneg d p q)
      H a b cst hH hcst hrel hcomm
