-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.sqrt_mul_sqrt
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.HermiteFarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) (hr : 0 ≤ r) : (Real.sqrt r : ℂ) * (Real.sqrt r : ℂ) = (r : ℂ) := by

  rw [← Complex.ofReal_mul, Real.mul_self_sqrt hr]
