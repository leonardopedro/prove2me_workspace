-- Generated from ChapterNavierStokesMomentumEsa.lean — theorem BookProof.NavierStokesFlow.MomentumEsa.ns_hamiltonian_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

theorem BookProof.NavierStokesFlow.MomentumEsa.ns_hamiltonian_essentiallySelfAdjointOn_core (d : ℕ) (p q : Fin d → ℕ → ℝ)
    (H : maxDom (nsSymbol d p q) →ₗ[ℂ] L2I ℕ) (a b cst : ℝ)
    (hH : SymmetricOn (maxDom (nsSymbol d p q)) H) (hcst : 0 ≤ cst)
    (hrel : ∀ x : maxDom (nsSymbol d p q),
      ‖H x‖ ^ 2 ≤ a * ‖diagMax (nsSymbol d p q) x‖ ^ 2 + b * ‖(x : L2I ℕ)‖ ^ 2)
    (hcomm : ∀ x : maxDom (nsSymbol d p q),
      |commForm H (diagMax (nsSymbol d p q)) x|
        ≤ cst * quadForm (diagMax (nsSymbol d p q)) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom (nsSymbol d p q)))) := by sorry
