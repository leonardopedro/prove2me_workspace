-- Generated from ChapterSirkSpectralGeometry.lean — solution of BookProof.ChapterSirkSpectralGeometry.crouzeix_domain_convexHull
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
import Theorems.Thm_BookProof_ChapterSirkEndToEnd_crouzeix_domain_transfer
open BookProof.ChapterSirkSpectralGeometry



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (V : G →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖) (S : Set ℂ) (hconv : Convex ℝ S) (hS : numRange X ⊆ S) :
    convexHull ℝ (numRange (compress V X)) ⊆ S := crouzeix_domain_transfer V X hViso S hconv hS
