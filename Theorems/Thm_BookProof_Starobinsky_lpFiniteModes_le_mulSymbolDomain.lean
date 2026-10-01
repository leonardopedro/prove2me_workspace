-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.lpFiniteModes_le_mulSymbolDomain
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky

variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.lpFiniteModes_le_mulSymbolDomain (lam : ℕ → ℝ) :
    (lpFiniteModes ℕ : Submodule ℂ L2Nat) ≤ mulSymbolDomain lam := by sorry
