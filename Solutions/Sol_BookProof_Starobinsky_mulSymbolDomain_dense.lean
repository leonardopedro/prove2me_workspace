-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.mulSymbolDomain_dense
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Theorems.Thm_BookProof_Starobinsky_lpFiniteModes_le_mulSymbolDomain
open BookProof.Starobinsky












open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) :
    Dense ((mulSymbolDomain lam : Submodule ℂ L2Nat) : Set L2Nat) := lpFiniteModes_dense.mono (by exact_mod_cast lpFiniteModes_le_mulSymbolDomain lam)
