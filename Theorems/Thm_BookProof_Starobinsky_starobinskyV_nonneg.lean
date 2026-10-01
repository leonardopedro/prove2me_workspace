-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.starobinskyV_nonneg
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky

variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.starobinskyV_nonneg {M alpha : ℝ} (halpha : 0 < alpha) (phi : ℝ) :
    0 ≤ starobinskyV M alpha phi := by sorry
