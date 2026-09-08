-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.fR_eq_scalarTensor
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky












open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (hM : M ≠ 0) (halpha : alpha ≠ 0) (R : ℝ) :
    fR M alpha R
      = M ^ 2 / 2 * scalaron M alpha R * R - Upot M alpha (scalaron M alpha R) := by

  have hM2 : M ^ 2 ≠ 0 := pow_ne_zero 2 hM
  simp only [fR, scalaron, Upot]
  field_simp
  ring
