-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.mulSymbolDomain_dense
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky

variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.mulSymbolDomain_dense (lam : ℕ → ℝ) :
    Dense ((mulSymbolDomain lam : Submodule ℂ L2Nat) : Set L2Nat) := by sorry
