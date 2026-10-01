-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.mulSymbolDomain_dense
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.FarisLavine
open BookProof.Starobinsky


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.mulSymbolDomain_dense (lam : ℕ → ℝ) :
    Dense ((mulSymbolDomain lam : Submodule ℂ L2Nat) : Set L2Nat) := by sorry
