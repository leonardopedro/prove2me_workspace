-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.fR_eq_scalarTensor
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky











open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.fR_eq_scalarTensor {M alpha : ℝ} (hM : M ≠ 0) (halpha : alpha ≠ 0) (R : ℝ) :
    fR M alpha R
      = M ^ 2 / 2 * scalaron M alpha R * R - Upot M alpha (scalaron M alpha R) := by sorry
